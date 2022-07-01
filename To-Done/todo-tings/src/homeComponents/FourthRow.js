import React from "react";
import { Typography } from "@mui/material";
//Importing Grid
import Grid from "@mui/material/Grid";
import { Box } from "@mui/system";
import messy from "../images/messy.png";
const FourthRow = () => {
  return (
    <Box className='third-ting'>
      <Grid container>
        <Grid item xs={12} md={6} paddingX={3}>
          <Box textAlign='center'>
            <Typography
              sx={{
                marginLeft: "10px",
                textDecoration: "line-through",
                textDecorationColor: "teal",
              }}
              variant='h3'
            >
              Drop the Clutter
            </Typography>
            <Box paddingTop={2.5}>
              <Typography variant='h6'>
                Yellow sticky notes and marble notebooks are a thing of the
                past. Not only does To-Done help keep your desk clean, but also
                syncs up to all of your logged in devices. Keeping your life in
                sync wherever you are.
              </Typography>
            </Box>
          </Box>
        </Grid>
        <Grid item xs={12} md={6}>
          <Box className='third-ting-img' textAlign='center'>
            <img alt='bro just see' src={messy}></img>
          </Box>
        </Grid>
      </Grid>
    </Box>
  );
};

export default FourthRow;
