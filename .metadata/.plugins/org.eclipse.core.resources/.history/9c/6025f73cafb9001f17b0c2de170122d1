package com.codingdojo.exam.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.exam.models.Team;

@Repository
public interface TeamRepository extends CrudRepository<Team, Long> {
    List<Team> findAllByOrderByTeamNameAsc();
    List<Team> findByTeamNameContaining(String name);
    List<Team> findAll();
}
