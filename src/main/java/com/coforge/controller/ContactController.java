package com.coforge.controller;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Component
@RequestMapping("/contact")
public class ContactController {

    @RequestMapping("/contact")
    public String showForm(){
        return "contact";
    }

    @RequestMapping(path="/processform", method = RequestMethod.POST)
    public String handleForm(@ModelAttribute User user, Model model) {
        model.addAttribute("user", user);
        System.out.println("user: " + user);
        model.addAttribute("user", user);
        return "success";
    }
}
