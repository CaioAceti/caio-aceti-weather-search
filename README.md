## Next Steps To improve Project:

### Protocol‑oriented design
    - Create a WeatherServiceProtocol defining fetchCoordinates(for:) and fetchWeather(for:).
    - This would allow easy dependency injection in the ViewModel, enabling mocking and unit testing.
    
### Unit tests
    - Add tests for the ViewModel to verify state transitions (idle → loading → success/empty/failure).
    - Add mock services to simulate API responses and error scenarios.
    
### Decoding strategy
    - Use JSONDecoder.keyDecodingStrategy = .convertFromSnakeCase to remove manual key mapping and improve readability.
    
### Error handling
    - Preserve the original thrown error instead of replacing it with a generic NSError.
    - Use the .empty state only when the API returns a valid response with no results.
