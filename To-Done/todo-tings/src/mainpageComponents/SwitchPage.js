import React from "react";
import Tabs from "@mui/material/Tabs";
import Tab from "@mui/material/Tab";

const SwitchPage = ({ handleChange, value }) => {
  return (
    <>
      <Tabs
        value={value}
        onChange={handleChange} //the handleChange method will run when the user clicks on a tab
        TabIndicatorProps={{
          style: {
            backgroundColor: "white",
          },
        }}
        textColor='inherit'
      >
        <Tab label='Reminders' sx={{ textColorPrimary: "teal" }} />{" "}
        {/* Create our tabs */}
        <Tab label=' Notes' />
      </Tabs>

      {/* <div>{value === 0 ? <Reminders /> : <Notes />}</div> */}
    </>
  );
};

export default SwitchPage;
