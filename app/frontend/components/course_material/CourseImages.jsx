import React from "react";

import {
  Box,
  Card,
  CardActionArea,
  IconButton,
  Typography,
} from "@mui/material";
import Grid from "@mui/material/Grid2";
import DownloadRoundedIcon from "@mui/icons-material/DownloadRounded";

const CourseImages = ({ images }) => (
  <Box sx={{ pt: 3 }}>
    <Typography variant="h6">{`Images (${images.length})`}</Typography>
    <Grid container direction="column" spacing={1} sx={{ py: 1 }}>
      {images.map((image) => (
        <Card key={image.id}>
          <CardActionArea
            href={image.downloadPath}
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
                <img src={`/${image.thumbnailUrl}`} alt={image.fileName} />
              </Grid>
              <Grid container size="grow" direction="column" sx={{ px: 2 }}>
                <Grid>
                  <Typography variant="subtitle1">{image.fileName}</Typography>
                </Grid>
                <Grid>
                  <Typography variant="body2">{image.fileType}</Typography>
                </Grid>
              </Grid>
              <Grid>
                <IconButton
                  color="primary"
                  href={image.downloadPath}
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

export default CourseImages;
