package com.codingdojo.exam.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.exam.models.LoggedInUser;
import com.codingdojo.exam.models.User;
import com.codingdojo.exam.repositories.UserRepository;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepo;

    // Method to register a new user
    public User register(User newUser, BindingResult result) {
        // Check if the user already has an account
        Optional<User> potentialUser = userRepo.findByEmail(newUser.getEmail());
        if (potentialUser.isPresent()) {
            result.rejectValue("email", "Matches", "An account already exists. Please login."); 
        }

        // Check if the passwords match
        if (!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches", "Passwords do not match."); 
        }

        // Return null if there are any validation errors
        if (result.hasErrors()) {
            return null;    		
        }

        // Hash and salt the password, then save the user in the database
        String hashedPassword = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashedPassword);
        return userRepo.save(newUser);
    }

    // Method to login a user
    public User login(LoggedInUser newLoginObject, BindingResult result) {
        // Check if the email exists in the database
        Optional<User> potentialUser = userRepo.findByEmail(newLoginObject.getEmail());
        if (!potentialUser.isPresent()) {
            result.rejectValue("email", "Matches", "Email not found. Try registering.");
            return null;
        }

        User user = potentialUser.get();

        // Check if the password matches
        if (!BCrypt.checkpw(newLoginObject.getPassword(), user.getPassword())) {
            result.rejectValue("password", "Matches", "Invalid login attempt. Try again.");
        }

        // Return null if there are any validation errors
        if (result.hasErrors()) {
            return null;
        } else {
            return user;
        }
    }

    // Method to get the logged-in user by ID
    public User getLoggedInUser(Long id) {
        Optional<User> potentialUser = userRepo.findById(id);
        return potentialUser.orElse(null);
    }
}
