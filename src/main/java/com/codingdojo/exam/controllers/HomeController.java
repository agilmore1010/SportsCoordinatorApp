package com.codingdojo.exam.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.exam.models.Player;
import com.codingdojo.exam.models.Team;
import com.codingdojo.exam.models.User;
import com.codingdojo.exam.services.TeamService;
import com.codingdojo.exam.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomeController {
	@Autowired
	private UserService users;
	@Autowired
	private TeamService teams;

	/**
	 * Displays the homepage with the list of teams and logged-in user info.
	 */
	@GetMapping("/homepage")
	public String homepage(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", users.getLoggedInUser(userId));
		model.addAttribute("teams", teams.getAllByNameAsc());
		return "homepage.jsp";
	}

	/**
	 * Displays the form to create a new team.
	 */
	@GetMapping("/new/team")
	public String createTeam(@ModelAttribute("team") Team team, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		return "createTeam.jsp";
	}

	/**
	 * Handles the creation of a new team.
	 */
	@PostMapping("/create/team")
	public String createTeam(@Valid @ModelAttribute("team") Team team, BindingResult result, HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		if (result.hasErrors()) {
			return "createTeam.jsp";
		}
		User developer = users.getLoggedInUser(userId);
		team.setUser(developer);
		teams.createTeam(team);
		redirectAttributes.addFlashAttribute("success", "Team created successfully!");
		return "redirect:/homepage";
	}

	/**
	 * Displays the details of a specific team.
	 */
	@GetMapping("/view/team/{id}")
	public String viewTeam(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("team", teams.getOneTeam(id));
		return "viewTeam.jsp";
	}

	/**
	 * Displays the form to edit an existing team.
	 */
	@GetMapping("/edit/team/{id}")
	public String editTeam(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		User currentUser = users.getLoggedInUser(userId);
		Team team = teams.getOneTeam(id);
		if (team == null || !team.getUser().equals(currentUser)) {
			return "redirect:/view/team/" + id;
		}
		model.addAttribute("team", teams.getOneTeam(id));
		return "editTeam.jsp";
	}

	/**
	 * Handles the update of an existing team.
	 */
	@PutMapping("/update/team/{id}")
	public String updateTeam(@Valid @ModelAttribute("team") Team team, BindingResult result, Model model,
			HttpSession session, RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		if (result.hasErrors()) {
			redirectAttributes.addFlashAttribute("error",
					"No fields can be blank, team name must be between 3-50 characters, skill level must be between 1-5, and the game day must be a valid day of the week!");
			return "redirect:/edit/team/" + team.getId();
		}
		team.setUser(users.getLoggedInUser(userId));
		teams.update(team);
		redirectAttributes.addFlashAttribute("success", "Team updated successfully!");
		return "redirect:/homepage";
	}

	/**
	 * Handles the deletion of a team.
	 */
	@DeleteMapping("/delete/team/{teamId}")
	public String deleteTeam(@PathVariable("teamId") Long teamId, HttpSession session,
			RedirectAttributes redirectAttributes) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		teams.deleteTeam(teamId);
		redirectAttributes.addFlashAttribute("success", "Team deleted successfully!");
		return "redirect:/homepage";
	}
	
	/**
	 * Handles adding players to a team.
	 */
	@PostMapping("/add/player/{teamId}")
	public String addPlayer(@PathVariable("teamId") Long teamId, @RequestParam("playerName") String playerName, HttpSession session, RedirectAttributes redirectAttributes) {
	    Long userId = (Long) session.getAttribute("userId");
	    if (userId == null) {
	        return "redirect:/";
	    }

	    Team team = teams.getOneTeam(teamId);
	    if (team == null) {
	        return "redirect:/homepage";
	    }

	    if (team.getPlayers().size() >= 9) {
	        redirectAttributes.addFlashAttribute("error", "The team is full!");
	    } else {
	        Player newPlayer = new Player();
	        newPlayer.setName(playerName);
	        team.addPlayer(newPlayer);
	        teams.update(team); // Save the updated team

	        redirectAttributes.addFlashAttribute("success", "Player added successfully!");
	    }

	    return "redirect:/view/team/" + teamId;
	}
}
