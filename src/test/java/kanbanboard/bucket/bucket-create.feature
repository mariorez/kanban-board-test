Feature: Bucket create endpoints

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Create a Bucket with valid data

    Given request
    """
    {
      "id": '#(generate.uuid())',
      "position": '#(generate.faker().number().numberBetween(1, 10000))',
      "name": '#(generate.faker().pokemon().name())'
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
      | id                 | position                                             | name
      | null               | #(generate.faker().number().numberBetween(1, 10000)) | #(generate.faker().lorem().word())
      | ''                 | #(generate.faker().number().numberBetween(1, 10000)) | #(generate.faker().lorem().word())
      | #(generate.uuid()) | 0                                                    | #(generate.faker().lorem().word())
      | #(generate.uuid()) | -1                                                   | #(generate.faker().lorem().word())
      | #(generate.uuid()) | #(generate.faker().number().numberBetween(1, 10000)) | null
      | #(generate.uuid()) | #(generate.faker().number().numberBetween(1, 10000)) | ''
      | #(generate.uuid()) | #(generate.faker().number().numberBetween(1, 10000)) | '   '
