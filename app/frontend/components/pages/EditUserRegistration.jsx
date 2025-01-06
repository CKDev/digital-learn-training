import React, { useState } from "react";
import { sendRequest } from "@api/Api";

import {
  TextField,
  Button,
  Box,
  Typography,
  Grid2 as Grid,
  Alert,
} from "@mui/material";

const EditUserRegistration = ({ currentEmail }) => {
  const [email, setEmail] = useState(currentEmail);
  const [password, setPassword] = useState("");
  const [passwordConfirmation, setPasswordConfirmation] = useState("");
  const [currentPassword, setCurrentPassword] = useState("");
  const [errors, setErrors] = useState({
    password: "",
    passwordConfirmation: "",
  });

  const validatePasswords = () => {
    const newErrors = {};

    if (password === "" && passwordConfirmation === "") {
      return true;
    }

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

    if (validatePasswords()) {
      let userData = {
        email: email,
        current_password: currentPassword,
        password: password,
        password_confirmation: passwordConfirmation,
      };

      let payload = JSON.stringify({ user: userData });
      let response = await sendRequest("/users", "PUT", payload);

      if (response.success) {
        localStorage.setItem("flash_message", response.data.message);
        window.location.reload();
      } else {
        setErrors({ submitError: response.message });
      }
    }
  };

  return (
    <Box component="form" onSubmit={handleSubmit}>
      <Grid container direction="column" gap={2}>
        <Typography variant="h6">Update Login Information</Typography>

        {!!errors.submitError && (
          <Alert severity="error">{errors.submitError}</Alert>
        )}

        <TextField
          label="Email"
          type="email"
          variant="outlined"
          fullWidth
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <TextField
          label="New Password (6 characters minimum)"
          type="password"
          variant="outlined"
          fullWidth
          value={password}
          onChange={(e) => setPassword(e.target.value)}
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
          error={!!errors.passwordConfirmation}
          helperText={errors.passwordConfirmation}
        />
        <TextField
          label="Current Password (required to make changes)"
          type="password"
          variant="outlined"
          fullWidth
          value={currentPassword}
          onChange={(e) => setCurrentPassword(e.target.value)}
          required
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          sx={{ mt: 2 }}
        >
          Update
        </Button>
      </Grid>
    </Box>
  );
};

export default EditUserRegistration;
