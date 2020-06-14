Feature: Bucket create endpoints

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def uuid = function() { return java.util.UUID.randomUUID() + ''}
    * def randomNumber = function(max) { return Math.floor(Math.random() * max) }

  Scenario: Create a Bucket with valid data

    Given request
    """
    {
      "id": '#(uuid())',
      "position": '#(randomNumber(1000))',
      "name": '#("Title - " + randomNumber(1000))'
    }
    """
    When method post
    Then status 201

  Scenario Outline: Can't create Bucket with invalid data

    Given url 'http://localhost:8080'
    And path 'v1/buckets'
    And request
    """
    {
      "id": <id>,
      "position": <position>,
      "name": <name>
    }
    """
    When method post
    Then status 400

    Examples:
      | id        | position              | name
      | null      | #(randomNumber(1000)) | #("Title - " + randomNumber(1000))
      | #(uuid()) | 0                     | #("Title - " + randomNumber(1000))
      | #(uuid()) | -1                    | #("Title - " + randomNumber(1000))
      | #(uuid()) | #(randomNumber(1000)) | ''
      | #(uuid()) | #(randomNumber(1000)) | '   '
