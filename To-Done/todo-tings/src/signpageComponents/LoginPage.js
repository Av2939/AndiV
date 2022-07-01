import React from "react";

//Importing other components
import SignIn from "./SignIn";
import SignUp from "./SignUp";

//Importing Hooks
import { useState } from "react";

//Material UI imports
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";
import { Box } from "@mui/system";

const LoginPage = () => {
  const [value, setValue] = useState(0);
  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  return (
    <div>
      <div>
        <Box
          display='flex'
          flexDirection='column'
          alignItems='center'
          justifyContent='center'
        >
          <Tabs
            value={value}
            onChange={handleChange} //the handleChange method will run when the user clicks on a tab
            TabIndicatorProps={{
              style: {
                backgroundColor: "teal",
                Color: "teal",
              },
            }}
            textColor='inherit'
          >
            <Tab label='Login' sx={{ textColorPrimary: "teal" }} />{" "}
            {/* Create our tabs */}
            <Tab label='Sign Up' />
          </Tabs>
        </Box>
      </div>
      <div>{value === 0 ? <SignIn /> : <SignUp />}</div>
    </div>
  );
};

export default LoginPage;
