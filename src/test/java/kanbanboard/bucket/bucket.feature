Feature: Bucket endpoints

  Scenario: create Bucket

    * def uuid =
      """
      function() { return java.util.UUID.randomUUID() + ''}
      """

    * def randomNumber =
      """
      function(max) { return Math.floor(Math.random() * max) }
      """

    * def bucket =
      """
      {
        "id": '#(uuid())',
        "position": '#(randomNumber(1000))',
        "name": '#("Title - " + randomNumber(1000))'
      }
      """

    Given url 'http://localhost:8080'
    And path 'v1/buckets'
    And request bucket
    When method post
    Then status 201
