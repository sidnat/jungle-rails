/// <reference types="cypress" />

describe('Jungle rails app', () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
})