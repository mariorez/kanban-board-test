Feature: Endpoint for Bucket creation
  In order to create a new Bucket
  As a Frontend application
  I need a REST endpoint to send Bucket data as JSON

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.DataGenerator')

  Scenario: A valid payload must create a Bucket only once

    * def payload =
    """
    {
      "id": '#(generate.uuid())',
      "position": '#(generate.randomNumber())',
      "name": '#(generate.randomName())'
    }
    """

    Given request payload
    When method post
    Then status 201

#    Given request payload
#    When method post
#    Then status 400
#    And match response contains 'Invalid duplicated data'


  Scenario Outline: Invalid fields must return error code 400

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
      | id                 | position!                  | name
      | null               | #(generate.randomNumber()) | #(generate.randomName())
      | ''                 | #(generate.randomNumber()) | #(generate.randomName())
      | #(generate.uuid()) | 0                          | #(generate.randomName())
      | #(generate.uuid()) | -1                         | #(generate.randomName())
      | #(generate.uuid()) | #(generate.randomNumber()) | null
      | #(generate.uuid()) | #(generate.randomNumber()) | ''
      | #(generate.uuid()) | #(generate.randomNumber()) | '   '