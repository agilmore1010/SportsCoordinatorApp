package com.codingdojo.exam.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.exam.models.Team;
import com.codingdojo.exam.repositories.TeamRepository;

@Service
public class TeamService {

    @Autowired
    private TeamRepository teamRepo;

    // Method to get all teams
    public List<Team> getAll() {
        return teamRepo.findAll();
    }

    // Method to get all teams ordered by name in ascending order
    public List<Team> getAllByNameAsc() {
        return teamRepo.findAllByOrderByTeamNameAsc();
    }

    // Method to create a new team
    public void createTeam(Team team) {
        teamRepo.save(team);
    }

    // Method to get a team by ID
    public Team getOneTeam(Long id) {
        return teamRepo.findById(id).orElse(null);
    }

    // Method to update a team
    public Team update(Team team) {
        return teamRepo.save(team);
    }

    // Method to delete a team by ID
    public void deleteTeam(Long id) {
        teamRepo.deleteById(id);
    }
}
