Feature: Test Bucket endpoints

  Scenario: create Bucket
    * def bucket =
      """
      {
        "id": "c86e2bc7-b777-4e72-a955-b62983018a85",
        "position": 1,
        "name": "TODO"
      }
      """

    Given url 'http://localhost:8080'
    And path 'v1/buckets'
    And request bucket
    When method post
    Then status 201
