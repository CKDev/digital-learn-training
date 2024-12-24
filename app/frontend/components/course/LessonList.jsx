import React from "react";
import {
  Box,
  Card,
  CardActionArea,
  Grid2 as Grid,
  Typography,
} from "@mui/material";

const LessonList = ({ lessons }) => (
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
                  href={lesson.lessonPath}
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
