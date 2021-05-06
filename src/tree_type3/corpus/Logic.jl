append!(truths, [
    Axiom("Definition of And", P ∧ False ⟹ False),
    Axiom("Definition of And", False ∧ P ⟹ False),
    Axiom("Definition of And", P ∧ True ⩶ P),
    Axiom("Definition of And", True ∧ P ⩶ P),
    Axiom("And is associative", @associative(∧, P, Q, R)),
    Axiom("And is commutative", @commutative(∧, P, Q)),
    Axiom("And is idempotent", @idempotent(∧, P)),
    Axiom("De Morgan's laws", P ∧ Q ⩶ ~(~P ∨ ~Q)),
    Axiom("And is absorbing over Or", P ∧ (P ∨ Q) ⟹ Q),
    Axiom("And is distributive over Or", @distributive(∧, ∨, P, Q, R)),
    Axiom("And is factorisable over Or", @factorisable(∧, ∨, P, Q, R)),

    Axiom("Law of noncontradiction", P ∧ ~P ⩶ False),
    Axiom("Law of excluded middle", P ∨ ~P ⩶ True)

    Axiom("Definition of Or", P ∨ True ⟹ True),
    Axiom("Definition of Or", True ∨ P ⟹ True),
    Axiom("Definition of Or", P ∨ False ⩶ P),
    Axiom("Definition of Or", False ∨ P ⩶ P),
    Axiom("Or is associative", @associative(∨, P, Q, R)),
    Axiom("Or is commutative", @commutative(∨, P, Q)),
    Axiom("Or is idempotent", @idempotent(∨, P)),
    Axiom("De Morgan's laws", P ∨ Q ⩶ ~(~P ∧ ~Q)),
    Axiom("Or is absorbing over And", P ∨ (P ∧ Q) ⟹ Q),
    Axiom("Or is distributive over And", @distributive(∨, ∧, P, Q, R)),
    Axiom("Or is factorisable over And", @factorisable(∨, ∧, P, Q, R)),
    Axiom("Or is the weaker And", P ∧ Q ⟹ P ∨ Q),

    Axiom("Definition of Not", ~False ⩶ True),
    Axiom("Definition of Not", ~True ⩶ False),
    # prove these
    #Axiom("De Morgan's laws", ~(P ∨ Q), ~P ∧ ~Q),
    #Axiom("De Morgan's laws", ~(P ∨ Q), ~P ∧ ~Q),
    Axiom("Not is involute", @involute(~, P)),

    Axiom("Definition of Implies", (P ⟹ Q) ⩶ ~P ∨ Q),
    # Theorem("Contrapositive", P ⟹ Q, ~Q ⟹ ~P, Proof([])),

    Axiom("Definition of Equivalent", (P ⩶ Q) ⩶ (P ⟹ Q) ∧ (Q ⟹ P)),
])
