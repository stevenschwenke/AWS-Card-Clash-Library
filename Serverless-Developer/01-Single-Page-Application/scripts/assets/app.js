document.getElementById('getFortune').addEventListener('click', async () => {
    try {
        // REPLACE THE URL WITH YOUR API GATEWAY URL:
        const response = await fetch('https://some-random-string.execute-api.eu-central-1.amazonaws.com/prod/fortune');
        const data = await response.text();
        document.getElementById('fortuneDisplay').innerText = data;
    } catch (error) {
        console.error('Error fetching fortune:', error);
    }
});
