export async function sendRequest(path, method, body, headers = null) {
  try {
    // Set default headers if needed
    if (headers == null) {
      headers = {
        "Content-Type": "application/json",
        Accept: "application/json",
      };
    }

    // Add csrf token from document
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");

    headers["X-CSRF-Token"] = csrfToken;

    // Send response
    const response = await fetch(path, {
      method: method,
      headers: headers,
      body: body,
    });

    if (!response.ok) {
      const responseData = await response.json();
      throw new Error(
        responseData.error || responseData.message || "Unexpected Server Error"
      );
    }
    const data = await response.json();
    return { success: true, data: data };
  } catch (err) {
    console.error("Error sending API request:", err);
    return { success: false, message: err.message };
  }
}
