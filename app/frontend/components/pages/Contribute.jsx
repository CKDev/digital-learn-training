import { Box, Button, Link, Typography } from "@mui/material";
import React from "react";

const Contribute = ({}) => (
  <Box>
    <Typography variant="h6">Contribute to DigitalLearn</Typography>
    <Box sx={{ mt: 3, mb: 3 }}>
      <Typography>
        Do you have great training materials? Ideas for new topics that
        DigitalLearn's online modules and classroom materials don't currently
        address? Let the Public Library Association know! Contact Us and feel
        free to send your materials, ask questions, or make suggestions.
      </Typography>
    </Box>
    <Box sx={{ mt: 3, mb: 3 }}>
      <Typography>
        Contact us via email:{" "}
        <Link
          href={
            "mailto:support@digitallearn.org?subject=Contact%20from%20DigitalLearn%20Training%20Site%20"
          }
        >
          support@digitallearn.org
        </Link>
      </Typography>
    </Box>
  </Box>
);

export default Contribute;
