import React from "react";
import { Typography } from "@mui/material";
//Importing Grid
import Grid from "@mui/material/Grid";
import { Box } from "@mui/system";
const SecondRow = () => {
  return (
    <Grid container>
      <Grid item xs={12} md={6} paddingX={3}>
        <Box className='second-ting' textAlign='center'>
          <Typography
            variant='h4'
            sx={{
              textDecoration: "line-through",
              display: "inline",
              textDecorationColor: "teal",
            }}
          >
            Two
          </Typography>
          <Typography
            sx={{ display: "inline", marginLeft: "10px" }}
            variant='h3'
          >
            One
          </Typography>
          <Typography
            sx={{ display: "inline", marginLeft: "10px" }}
            variant='h3'
          >
            App
          </Typography>
          <Box className='second-ting-p' paddingTop={3} paddingX={3}>
            <Typography variant='p'>
              Id labore excepteur ex officia exercitation eu voluptate est.
              Fugiat sit non aute velit. Ex ex pariatur irure laboris. Nisi
              minim in dolore culpa enim et aute. Non sit sint sint qui laboris.
              Exercitation id culpa elit aliquip anim. Labore nisi commodo nisi
              eiusmod dolore sunt consequat.
            </Typography>
          </Box>
        </Box>
      </Grid>
      <Grid item xs={12} md={6} paddingTop={10}>
        <img
          className='second-ting-img'
          alt='bro just see'
          src='https://images.pexels.com/photos/10147767/pexels-photo-10147767.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
        ></img>
      </Grid>
    </Grid>
  );
};

export default SecondRow;
