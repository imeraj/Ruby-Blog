Feature: Article list
  List all the articles stored in this blog

  Scenario: List artciles
    When the client requests GET /articles
    Then the response should be JSON:
    """
        {
          "success": true,
          "articles": "[{\"id\":1,\"title\":\"Hello\",\"text\":\"Hello World\"},{\"id\":3,\"title\":\"Rails Blog!\",\"text\":\"Testing a Rails blog!\"},{\"id\":4,\"title\":\"Course!\",\"text\":\"Ruby on Rails!\"},{\"id\":5,\"title\":\"Monstar\",\"text\":\"Monstar Lab!\"},{\"id\":6,\"title\":\"Ruby!\",\"text\":\"Pragmatic Ruby Programming!\"}]"
        }
    """

