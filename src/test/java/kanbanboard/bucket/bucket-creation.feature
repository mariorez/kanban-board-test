Feature: Endpoint for Bucket creation
  In order to create a new Bucket
  As a Frontend application
  I need a REST endpoint to send Bucket data as JSON

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.DataGenerator')

  Scenario: A valid payload must create a Bucket only once

    * def uuid = generate.uuid()
    * def position = generate.randomNumber()
    * def expectedLocation = '/v1/buckets/' + uuid
    * def payload =
    """
    {
      id: '#(uuid)',
      position: '#(position)',
      name: '#(generate.randomName())'
    }
    """
    Given request payload
    When method post
    Then status 201
    And match responseHeaders['Location'][0] == expectedLocation

    Given request payload
    When method post
    Then status 400
    And match response == { message: 'Invalid duplicated data', id: '#(uuid)', position: '#(position)' }

  Scenario Outline: Invalid fields must return error code 400

    Given url 'http://localhost:8080'
    And path 'v1/buckets'
    And request
    """
    {
      id: <id>,
      position: <position>,
      name: <name>
    }
    """
    When method post
    Then status 400
    And match response == <expected>

    Examples:
      | id                 | position!                  | name                     | expected
      | null               | 0                          | ''                       | { name: 'must not be blank', id: 'must not be null', position: 'must be greater than 0' }
      | #(generate.uuid()) | -1                         | #(generate.randomName()) | { position: 'must be greater than 0' }
      | #(generate.uuid()) | #(generate.randomNumber()) | null                     | { name: 'must not be blank' }
      | #(generate.uuid()) | #(generate.randomNumber()) | '   '                    | { name: 'must not be blank' }
