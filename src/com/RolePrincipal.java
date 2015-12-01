package com;

/**
 * Created by Gartusk on 11/16/2015.
 */
import java.security.Principal;

public class RolePrincipal implements Principal {

    private String name;

    public RolePrincipal(String name) {
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