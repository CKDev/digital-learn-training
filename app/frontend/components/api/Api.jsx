export async function sendRequest(path, method, body, headers = null) {
  try {
    if (headers == null) {
      headers = {};
    }

    headers["Accept"] = "application/json";

    if (!(body instanceof FormData)) {
      headers["Content-Type"] = "application/json";
    }

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

    const responseText = await response.text();
    let responseData;
    try {
      responseData = JSON.parse(responseText);
    } catch {
      console.error(`Non-JSON response (HTTP ${response.status}):`, responseText.slice(0, 500));
      throw new Error(`Server returned HTTP ${response.status} with non-JSON response`);
    }

    if (!response.ok) {
      throw new Error(responseData.error || responseData.message || "Unexpected Server Error");
    }
    return { success: true, data: responseData };
  } catch (err) {
    console.error("Error sending API request:", err);
    return { success: false, message: err.message };
  }
}
