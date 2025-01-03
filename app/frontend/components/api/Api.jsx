export async function sendRequest(path, method, body) {
  try {
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");
    const response = await fetch(path, {
      method: method,
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-Token": csrfToken,
      },
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
    return { success: false, message: err.message };
  }
}
