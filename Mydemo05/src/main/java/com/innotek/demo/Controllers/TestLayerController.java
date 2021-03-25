package com.innotek.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestLayerController {
    @GetMapping("/layertest")
    public String testLayer(){
        return "/test/layertest";
    }

    @GetMapping("/test03")
    public String test03(){
        return "/test/test03";
    }

    @GetMapping("/test04")
    public String test04(){
        return "/test/test04";
    }
}
