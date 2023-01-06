describe("Product Details", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000");
  });

  it("it navigates from the home page to the product detail page by clicking on a product.", () => {
    cy.get(".products article").should("be.visible").eq(0).click();

    cy.get(".product-detail").should("be.visible");
  });
});