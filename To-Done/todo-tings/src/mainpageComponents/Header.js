import React from "react";
import AppBar from "@mui/material/AppBar";
import Box from "@mui/material/Box";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import SwitchPage from "./SwitchPage";
import Button from "@mui/material/Button";
const Header = ({ handleLogOut, handleChange, value }) => {
  return (
    <Box sx={{ flexGrow: 1, paddingTop: "0px" }}>
      <AppBar position='static' sx={{ backgroundColor: "teal" }}>
        <Toolbar sx={{ height: "60px" }}>
          <Box>
            <Typography variant='h5'>To-done</Typography>
          </Box>
          <Box sx={{ margin: "auto" }}>
            <SwitchPage handleChange={handleChange} value={value} />
          </Box>

          <Box>
            <Button variant='primary' onClick={handleLogOut}>
              LogOut
            </Button>
          </Box>
        </Toolbar>
      </AppBar>
    </Box>
  );
};

export default Header;
