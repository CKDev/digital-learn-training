import { Alert, Snackbar, TextField } from "@mui/material";
import React, { useState } from "react";
import { updateCourseMaterial } from "../../../api/CourseMaterialsApi";

const SortOrderInput = ({ course, onSortOrderChange }) => {
  const defaultSnackbarData = {
    open: false,
    message: "",
    type: "info",
  };
  const [sortOrder, setSortOrder] = useState(course.sortOrder);
  const [error, setError] = useState("");
  const [snackbarData, setSnackbarData] = useState(defaultSnackbarData);

  const handleBlur = async () => {
    if (sortOrder !== course.sortOrder) {
      const payload = JSON.stringify({
        course_material: { sort_order: sortOrder },
      });
      let response = await updateCourseMaterial(course.id, payload, false);

      if (response.success) {
        onSortOrderChange(course.id, sortOrder);
        setSnackbarData({
          open: true,
          message: "Sort Order Updated!",
          type: "success",
        });
      } else {
        setSnackbarData({
          open: true,
          message: response.message,
          type: "error",
        });
      }
    }
  };

  const validSortOrder = (value) => !isNaN(Number(value)) && Number(value) > 0;

  const handleChange = (event) => {
    const value = event.target.value;
    setSortOrder(value);

    if (!validSortOrder(value)) {
      setError("Invalid sort order");
    } else {
      setError("");
    }
  };

  const handleKeyDown = (event) => {
    if (event.key === "Enter" && validSortOrder(event.target.value)) {
      event.target.blur(); // Handle blur w/ blur event
    }
  };

  const handleSnackbarClose = (_event, _reason) => {
    setSnackbarData(defaultSnackbarData);
  };

  return (
    <>
      <Snackbar
        open={snackbarData.open}
        autoHideDuration={6000}
        onClose={handleSnackbarClose}
        message={snackbarData.message}
      >
        <Alert
          onClose={handleSnackbarClose}
          severity={snackbarData.severity}
          variant="filled"
          sx={{ width: "100%" }}
        >
          {snackbarData.message}
        </Alert>
      </Snackbar>
      <TextField
        value={sortOrder}
        onChange={handleChange}
        onBlur={handleBlur}
        onKeyDown={handleKeyDown}
        error={error != ""}
      />
    </>
  );
};

export default SortOrderInput;
