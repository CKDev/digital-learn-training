import React from "react";
import {
  Box,
  Button,
  Card,
  CardActionArea,
  Grid2 as Grid,
  Typography,
} from "@mui/material";
import ForwardRoundedIcon from "@mui/icons-material/ForwardRounded";
import PlayArrowRoundedIcon from "@mui/icons-material/PlayArrowRounded";
import ThemedIcon from "../ThemedIcon";

const LessonList = ({ lessons, currentLessonId }) => (
  <Box sx={{ pt: 3 }}>
    <Typography variant="h6">{`Course Activities (${lessons.length})`}</Typography>
    <Grid container direction="column" spacing={1} sx={{ py: 1 }}>
      {lessons.map((lesson) => (
        <Card key={lesson.id}>
          <CardActionArea href={lesson.lessonPath} sx={{ p: 1 }}>
            <Grid
              container
              direction="row"
              justifyContent="space-between"
              alignItems="center"
            >
              <Grid sx={{ px: 1 }}>
                <ThemedIcon iconClass={PlayArrowRoundedIcon} />
              </Grid>
              <Grid container size="grow" direction="column" sx={{ px: 2 }}>
                <Grid>
                  <Typography variant="subtitle1">{lesson.title}</Typography>
                </Grid>
                <Grid>
                  <Typography variant="body2">{lesson.summary}</Typography>
                </Grid>
              </Grid>
              <Grid>
                <Button
                  size="small"
                  variant="text"
                  disableElevation
                  endIcon={<ForwardRoundedIcon />}
                >
                  Start Lesson
                </Button>
              </Grid>
            </Grid>
          </CardActionArea>
        </Card>
      ))}
    </Grid>
  </Box>
);

export default LessonList;
