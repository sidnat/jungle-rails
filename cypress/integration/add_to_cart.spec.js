describe('Add to cart', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
  })

  it("adds an item to the cart and increases the my cart by 1", () => {
    cy.get(".products article").should("be.visible");
    cy.contains("My Cart (0)").should("exist");
    cy.get(".products article").eq(1).find(".btn").click({ force: true });
    cy.contains("My Cart (0)").should("not.exist");
  });

})

