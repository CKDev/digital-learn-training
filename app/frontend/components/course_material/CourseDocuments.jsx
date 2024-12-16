import React from "react";

import {
  Box,
  Card,
  CardActionArea,
  IconButton,
  Typography,
} from "@mui/material";
import Grid from "@mui/material/Grid2";
import InsertDriveFileRoundedIcon from "@mui/icons-material/InsertDriveFileRounded";
import DownloadRoundedIcon from "@mui/icons-material/DownloadRounded";
import ThemedIcon from "../ThemedIcon";

const CourseDocuments = ({ files }) => (
  <Box sx={{ pt: 3 }}>
    <Typography variant="h6">{`Documents (${files.length})`}</Typography>
    <Grid container direction="column" spacing={1} sx={{ py: 1 }}>
      {files.map((file) => (
        <Card key={file.id}>
          <CardActionArea
            href={file.downloadPath}
            target="_blank"
            sx={{ p: 1 }}
          >
            <Grid
              container
              direction="row"
              justifyContent="space-between"
              alignItems="center"
            >
              <Grid sx={{ px: 1 }}>
                <ThemedIcon iconClass={InsertDriveFileRoundedIcon} />
              </Grid>
              <Grid container size="grow" direction="column" sx={{ px: 2 }}>
                <Grid>
                  <Typography variant="subtitle1">{file.fileName}</Typography>
                </Grid>
                <Grid>
                  <Typography variant="body2">{file.fileType}</Typography>
                </Grid>
              </Grid>
              <Grid>
                <IconButton
                  color="primary"
                  href={file.downloadPath}
                  target="_blank"
                  aria-label="Download"
                >
                  <DownloadRoundedIcon />
                </IconButton>
              </Grid>
            </Grid>
          </CardActionArea>
        </Card>
      ))}
    </Grid>
  </Box>
);

export default CourseDocuments;
