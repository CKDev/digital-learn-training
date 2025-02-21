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

const SignIn = ({ signInPath, forgotPasswordPath, learnersSignInPath }) => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const csrfSelector = document.querySelector('meta[name="csrf-token"]');
      const csrfToken = !!csrfSelector
        ? csrfSelector.getAttribute("content")
        : "";

      const response = await fetch(signInPath, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify({ user: { email: email, password: password } }),
      });

      if (!response.ok) {
        const responseData = await response.json();
        throw new Error(
          responseData.error || responseData.message || "Sign-in failed"
        );
      }

      const data = await response.json();
      console.log("Sign-in success:", data);
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
          Sign In
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
        <TextField
          label="Password"
          type="password"
          variant="outlined"
          fullWidth
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          sx={{ mt: 2 }}
        >
          Sign In
        </Button>
        <Link href={forgotPasswordPath}>Forgot your Password?</Link>
        <Button
          href={learnersSignInPath}
          variant="outlined"
          fillWidth
          sx={{ mt: 2 }}
        >
          Sign In with Learners Account
        </Button>
      </Grid>
    </Box>
  );
};

export default SignIn;
