import React from "react";
import { Typography } from "@mui/material";
//Importing Grid
import Grid from "@mui/material/Grid";
import { Box } from "@mui/system";
import checklist from "../images/checklist.png";
import notebook from "../images/notebook.png";
const ThirdRow = () => {
  return (
    <Grid container>
      <Grid item xs={12} md={6} paddingX={3}>
        <Box className='second-ting' textAlign='center'>
          <Box>
            <Typography
              sx={{ display: "inline", marginLeft: "10px" }}
              variant='h4'
            >
              Reminders at a Glance
            </Typography>
          </Box>
          <img className='third-row' alt='bro just see' src={checklist}></img>
          <Box paddingTop={2.5} paddingX={6}>
            <Typography variant='h6'>
              Quickly add reminders for the things you don't want to miss. Each
              reminder can be quickly added or deleted. And you can set the
              state of whether the task is still inprogress or finished.
            </Typography>
          </Box>
        </Box>
      </Grid>

      <Grid item xs={12} md={6} paddingX={3}>
        <Box className='second-ting' textAlign='center'>
          <Box>
            <Typography
              sx={{ display: "inline", marginLeft: "10px" }}
              variant='h4'
            >
              Noting the Next Big Thing
            </Typography>
          </Box>
          <img
            className='third-row-notebook'
            alt='bro just see'
            src={notebook}
          ></img>
          <Box paddingTop={2.5} paddingX={6}>
            <Typography variant='h6'>
              Just like Reminders, Notes helps you keep organized throughout the
              day. Use it to take notes for a class or use it as a canvas for
              your next big idea.
            </Typography>
          </Box>
        </Box>
      </Grid>
    </Grid>
  );
};

export default ThirdRow;
