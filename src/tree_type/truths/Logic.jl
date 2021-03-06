logic = [
    Axiom("Definition of And", P ∧ FALSE, FALSE),
    Axiom("Definition of And", FALSE ∧ P, FALSE),
    Axiom("Definition of And", P ∧ TRUE, P),
    Axiom("Definition of And", TRUE ∧ P, P),
    Axiom("And is associative", @left_associative(∧, P, Q, R)...),
    Axiom("And is associative", @right_associative(∧, P, Q, R)...),
    Axiom("And is commutative", @commutative(∧, P, Q)...),
    Axiom("And is idempotent", @idempotent(∧, P)...),
    Axiom("De Morgan's laws", P ∧ Q, ~(~P ∨ ~Q)),
    Axiom("De Morgan's laws", ~(~P ∨ ~Q), P ∧ Q),
    Axiom("And is absorbing over Or", P ∧ (P ∨ Q), Q),
    Axiom("And is distributive over Or", @distributive(∧, ∨, P, Q, R)...),
    Axiom("And is factorisable over Or", @factorisable(∧, ∨, P, Q, R)...),

    Axiom("Law of noncontradiction", P ∧ ~P, FALSE),
    # now prove Q ∨ ~Q is true which is the law of excluded middle

    Axiom("Definition of Or", P ∨ TRUE, TRUE),
    Axiom("Definition of Or", TRUE ∨ P, TRUE),
    Axiom("Definition of Or", P ∨ FALSE, P),
    Axiom("Definition of Or", FALSE ∨ P, P),
    Axiom("Or is associative", @left_associative(∨, P, Q, R)...),
    Axiom("Or is associative", @right_associative(∨, P, Q, R)...),
    Axiom("Or is commutative", @commutative(∨, P, Q)...),
    Axiom("Or is idempotent", @idempotent(∨, P)...),
    Axiom("De Morgan's laws", P ∨ Q, ~(~P ∧ ~Q)),
    Axiom("De Morgan's laws", ~(~P ∧ ~Q), P ∨ Q),
    Axiom("Or is absorbing over And", P ∨ (P ∧ Q), Q),
    Axiom("Or is distributive over And", @distributive(∨, ∧, P, Q, R)...),
    Axiom("Or is factorisable over And", @factorisable(∨, ∧, P, Q, R)...),
    Axiom("Or is the weaker And", P ∧ Q, P ∨ Q),

    Axiom("Definition of Not", ~FALSE, TRUE),
    Axiom("Definition of Not", ~TRUE, FALSE),
    Axiom("De Morgan's laws", ~(P ∨ Q), ~P ∧ ~Q),
    Axiom("De Morgan's laws", ~(P ∨ Q), ~P ∧ ~Q),
    Axiom("Not is involute", @involute(~, P)...),
    Axiom("Not is involute", @re_involute(~, P)...),

    Axiom("Definition of Implies", P ⟹ Q, ~P ∨ Q),
    Axiom("Definition of Implies", ~P ∨ Q, P ⟹ Q),
    Theorem("Contrapositive", P ⟹ Q, ~Q ⟹ ~P, Proof([])),

    Axiom("Definition of Equivalent", P ≡ Q, (P ⟹ Q) ∧ (Q ⟹ P)),
    Axiom("Definition of Equivalent", (P ⟹ Q) ∧ (Q ⟹ P), P ≡ Q),
]
