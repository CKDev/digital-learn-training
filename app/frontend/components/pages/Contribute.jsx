import { Box, Link, Typography } from "@mui/material";
import React from "react";

const Contribute = ({}) => (
  <Box>
    <Typography variant="h6">Contribute to DigitalLearn</Typography>
    <Box sx={{ mt: 3, mb: 3 }}>
      <Typography sx={{ mb: 3 }}>
        Do you have great training materials, ideas for new topics that
        DigitalLearn's online modules and classroom materials don't currently
        address?
      </Typography>
      <Typography sx={{ mb: 3 }}>
        Let the Public Library Association know!
      </Typography>
      <Typography sx={{ mb: 3 }}>
        Contact us at the email address below and feel free to send your
        materials, ask questions, or make suggestions.
      </Typography>
    </Box>
    <Box sx={{ mt: 3, mb: 3 }}>
      <Typography>
        Send us an Email:{" "}
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
