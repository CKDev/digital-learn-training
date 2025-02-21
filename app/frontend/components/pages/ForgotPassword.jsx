import React, { useState } from "react";

import {
  TextField,
  Button,
  Box,
  Typography,
  Alert,
  Link,
  Grid2 as Grid,
} from "@mui/material";

const ForgotPassword = ({ signInPath, requestPasswordResetPath }) => {
  const [email, setEmail] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const csrfToken = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");
      const response = await fetch(requestPasswordResetPath, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify({ user: { email: email } }),
      });

      if (!response.ok) {
        const responseData = await response.json();
        throw new Error(
          responseData.error ||
            responseData.message ||
            "Failed to request password reset instructions. Please try again."
        );
      }

      const data = await response.json();
      console.log("Reset Password success:", data);
      localStorage.setItem("flash_message", data.message);
      window.location = data.redirectPath;
    } catch (err) {
      setError(err.message);
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
          Forgot your Password?
        </Typography>

        {error && <Alert severity="error">{error}</Alert>}

        <TextField
          label="Email"
          type="email"
          variant="outlined"
          fullWidth
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          sx={{ mt: 2 }}
        >
          Send Password Reset Instructions
        </Button>
        <Link href={signInPath}>Return to Log In</Link>
      </Grid>
    </Box>
  );
};

export default ForgotPassword;
