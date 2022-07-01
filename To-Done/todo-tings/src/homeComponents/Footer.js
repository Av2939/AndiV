import * as React from "react";
import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Toolbar from "@mui/material/Toolbar";
import { IconButton } from "@mui/material";
import GitHubIcon from "@mui/icons-material/GitHub";
import LinkedInIcon from "@mui/icons-material/LinkedIn";

const Footer = () => {
  return (
    <Box sx={{ flexGrow: 1, paddingTop: "20px" }}>
      <AppBar position='static' sx={{ backgroundColor: "teal" }}>
        <Box sx={{ margin: "auto" }}>
          <Toolbar sx={{ height: "10px" }}>
            <IconButton
              onClick={() => window.open("https://github.com/Av2939/AndiV")}
            >
              <GitHubIcon sx={{ color: "white", fontSize: "40px" }} />
            </IconButton>
            <IconButton
              onClick={() =>
                window.open("https://www.linkedin.com/in/andi-volaj/")
              }
            >
              <LinkedInIcon sx={{ color: "white", fontSize: "40px" }} />
            </IconButton>
          </Toolbar>
        </Box>
      </AppBar>
    </Box>
  );
};

export default Footer;
