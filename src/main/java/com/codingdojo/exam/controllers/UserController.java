package com.codingdojo.exam.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.exam.models.LoggedInUser;
import com.codingdojo.exam.models.User;
import com.codingdojo.exam.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
    @Autowired
    private UserService users;
    
    /**
     * Displays the login and registration page.
     */
    @GetMapping("/")
    public String index(Model model) {
        // Bind empty User and LoggedInUser objects to the JSP to capture the form input
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoggedInUser());
        return "index.jsp";
    }
    
    /**
     * Handles user registration.
     */
    @PostMapping("/register/user")
    public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        users.register(newUser, result);
        if (result.hasErrors()) {
            model.addAttribute("newLogin", new LoggedInUser());
            return "index.jsp";
        } else {
            session.setAttribute("userId", newUser.getId());
            redirectAttributes.addFlashAttribute("success", "Registration successful!");
            return "redirect:/homepage";
        }
    }
    
    /**
     * Handles user login.
     */
    @PostMapping("/login/user")
    public String loginUser(@Valid @ModelAttribute("newLogin") LoggedInUser newLogin, BindingResult result, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        // Call the user service for login 
        User user = users.login(newLogin, result);
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        } else {
            session.setAttribute("userId", user.getId());
            redirectAttributes.addFlashAttribute("success", "Login successful!");
            return "redirect:/homepage";
        }
    }
    
    /**
     * Handles user logout.
     */
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "Logged out successfully!");
        return "redirect:/";
    }
}
