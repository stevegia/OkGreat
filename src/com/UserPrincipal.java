package com;

/**
 * Created by Gartusk on 11/16/2015.
 */
import java.security.Principal;

public class UserPrincipal implements Principal {

    private String name;
    private String test;

    public UserPrincipal(String name) {
        super();
        this.name = name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }

}