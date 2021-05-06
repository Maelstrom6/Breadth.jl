append!(truths, [
    Axiom("", Sets ⊂ Ω ⟹ True),
    Axiom("", Statements ⊂ Ω ⟹ True),
    Axiom("", Statements ⊂ Sets ⟹ False),
    Axiom("", Sets ⊂ Statements ⟹ False),

    Axiom("Definition of the universal set", P ⊂ Ω ⟹ True),
    Axiom("Definition of the universal set", x ∈ Ω ⟹ True),
    Axiom("Definition of the empty set", ∅ ⊂ A ⟹ True),
    Axiom("Definition of the empty set", x ∈ ∅ ⟹ False),
    Axiom("Equal sets are subsets", A ⊂ A ⟹ True),

    Axiom("Definition of Element Of", x ∈ (A ∩ B) ⟹ (x ∈ A) ∧ (x ∈ B)),
    Axiom("Definition of Element Of", (x ∈ A) ∧ (x ∈ B) ⟹ x ∈ (A ∩ B)),
    Axiom("Definition of Element Of", x ∈ (A ∪ B) ⟹ (x ∈ A) ∨ (x ∈ B)),
    Axiom("Definition of Element Of", (x ∈ A) ∨ (x ∈ B) ⟹ x ∈ (A ∪ B)),

    Axiom("Flatten Condition Set", ConditionSet(y, y ∈ A) ⩶ A),  # todo: change to f(x)
    # Axiom("Definition of Subset", ((x ∈ A) ⟹ (x ∈ B)) ⩶ A ⊂ B),

    # Axiom("Definition of the universal set", x ∈ (P ∪ Ω) ⟹ x ∈ Ω),

    # Theorem("Intersections are subsets of Unions", x ∈ (A ∩ B), x ∈ (A ∪ B), Proof([])),
    # Theorem("Intersections are subsets of Unions", (A ∩ B) ⊂ (A ∪ B), True, Proof([])),
])
