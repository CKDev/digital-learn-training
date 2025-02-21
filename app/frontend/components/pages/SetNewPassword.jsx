import React, { useState } from "react";

import {
  TextField,
  Button,
  Box,
  Typography,
  Link,
  Grid2 as Grid,
} from "@mui/material";

const SetNewPassword = ({
  resetPasswordToken,
  signInPath,
  setNewPasswordPath,
}) => {
  const [password, setPassword] = useState("");
  const [passwordConfirmation, setPasswordConfirmation] = useState("");
  const [errors, setErrors] = useState({
    password: "",
    passwordConfirmation: "",
  });

  const validate = () => {
    const newErrors = {};

    if (password.length < 6) {
      newErrors.password = "Password must be at least 6 characters long.";
    }

    if (password !== passwordConfirmation) {
      newErrors.passwordConfirmation = "Passwords do not match.";
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (validate()) {
      try {
        const csrfToken = document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content");
        const response = await fetch(setNewPasswordPath, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
            "X-CSRF-Token": csrfToken,
          },
          body: JSON.stringify({
            user: {
              reset_password_token: resetPasswordToken,
              password: password,
              password_confirmation: passwordConfirmation,
            },
          }),
        });

        if (!response.ok) {
          const responseData = await response.json();
          throw new Error(
            responseData.error ||
              responseData.message ||
              "Error updating password"
          );
        }

        const data = await response.json();
        console.log("Password Reset success:", data);
        window.location = data.redirectPath;
      } catch (err) {
        setErrors({ submitError: err.message });
      }
    }
  };

  return (
    <Box
      component="form"
      onSubmit={handleSubmit}
      sx={{
        maxWidth: 600,
        my: 0,
        mx: "auto",
        p: 4,
        borderRadius: 2,
      }}
    >
      <Grid container direction="column" gap={2} alignItems="center">
        <Typography variant="h6" textAlign="center">
          Change your Password
        </Typography>

        <TextField
          label="New Password (6 characters minimum)"
          type="password"
          variant="outlined"
          fullWidth
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
          error={!!errors.password}
          helperText={errors.password}
        />
        <TextField
          label="Confirm New Password"
          type="password"
          variant="outlined"
          fullWidth
          value={passwordConfirmation}
          onChange={(e) => setPasswordConfirmation(e.target.value)}
          required
          error={!!errors.passwordConfirmation}
          helperText={errors.passwordConfirmation}
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          sx={{ mt: 2 }}
        >
          Change my Password
        </Button>
        <Link href={signInPath}>Log In</Link>
      </Grid>
    </Box>
  );
};

export default SetNewPassword;
