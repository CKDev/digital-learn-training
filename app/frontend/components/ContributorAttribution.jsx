import React from "react";
import { Grid2, Typography } from "@mui/material";
import attCourseLogo from "../assets/images/att_course_logo.svg";

const ContributorAttribution = ({}) => (
  <Grid2 container display="flex" direction="column">
    <Typography variant="caption">Made Possible By:</Typography>
    <img src={attCourseLogo} />
  </Grid2>
);

export default ContributorAttribution;
