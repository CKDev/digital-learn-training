import { Box, Button, Grid2, Typography } from "@mui/material";
import React from "react";

const AdditionalResources = ({}) => {
  const checklistDownloadPath = "tech-skills-checklist-survey-only.pdf";
  const facebookUrl = "https://www.facebook.com/digitallearn.org/";

  return (
    <Box>
      <Grid2
        container
        spacing={4}
        display="flex"
        direction="column"
        justifyContent="space-between"
      >
        <Box>
          <Typography variant="h6">Tech Skills Checklist</Typography>
          <Box sx={{ mt: 3, mb: 3 }}>
            <Typography>
              A tool for Public Library Supervisors & Staff to Evaluate their
              Tech Skills
            </Typography>
          </Box>
          <Box sx={{ mt: 3, mb: 3 }}>
            <Button
              variant="contained"
              color="primary"
              href={checklistDownloadPath}
              target="_blank"
            >
              Download Checklist (PDF)
            </Button>
          </Box>
        </Box>
        <Box>
          <Typography variant="h6">Social Media</Typography>
          <Box sx={{ mt: 3, mb: 3 }}>
            <Typography>Follow DigitalLearn on Facebook</Typography>
          </Box>
          <Button
            variant="contained"
            color="primary"
            onClick={() => window.open(facebookUrl, "_blank")}
          >
            Visit Us On Facebook
          </Button>
        </Box>
      </Grid2>
    </Box>
  );
};

export default AdditionalResources;
