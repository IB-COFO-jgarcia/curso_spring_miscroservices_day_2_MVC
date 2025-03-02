package com.coforge.controller;

import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/users")
public class HomeController {

    @RequestMapping(path = "/home", method = RequestMethod.GET)
    public String home(Model model){
        model.addAttribute("name", "José Macías");
        model.addAttribute("Designation", "PP");
        return "index";
    }

    @RequestMapping("/about")
    public String about(){
        return "about";
    }

    @RequestMapping("/help")
    public ModelAndView help(){

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.addObject("name", "José Macías");
        modelAndView.addObject("RollNo", 1234);
        List<Integer> list = new ArrayList<Integer>();
        list.add(12);
        list.add(2345);
        list.add(2134);
        modelAndView.addObject("marks", list);
        modelAndView.setViewName("help");

        return modelAndView;
    }
}
