# Useful Functions

This is taken from the
[guide](http://sbml.org/Software/libSBML/libSBML_R_Example_Programs)
on [libsbml.org](libsbml.org)

## Components to Address

The model components are species, parameters, reactions, compartments,
unit definitions, and functions (λ expressions).

The model is written to file by
```R
writeSBML(model, "sthsthsth.xml");
```

In General, math expressions can be written directly as mathml, or in infix notation strings:
```R
x <- parseFormula("k1*x1*x2")
formulaToString(x)
[1] "k1 * x1 * x2"

## or

xmlns <- '<math xmlns="http://www.w3.org/1998/Math/MathML">'
mathXMLString <- paste0(xmlns,
                        "<apply>",
                        " <times/>",
                        "  <ci> k1 </ci>",
                        "  <ci> x1 </ci>",
                        "  <ci> x2 </ci>",
                        " </apply>",
                        "</math>");
y <- readMathMLFromString(mathXMLString);
formulaToString(y)
[1] "k1 * x1 * x2"
```

The function `parseFormula` is by far the most important function in
this Document. Most of the sbml file can be written without using
libsbml, but converting infix math strings to MathML is not trivial.

### Unit Definitions

```R
unitdef <- Model_createUnitDefinition(model);
UnitDefinition_setId(unitdef,id);
for (i in 1:n){
 u <- UnitDefinition_createUnit(unitdef);
 Kind <- switch(unit$kind[i],
                litre="UNIT_KIND_LITRE",
                metre="UNIT_KIND_METRE",
                second="UNIT_KIND_SECOND",
                mole="UNIT_KIND_MOLE",
                gram="UNIT_KIND_GRAM",
                "UNIT_KIND_DIMENSIONLESS")
 Unit_setKind(u, Kind);
 Unit_setExponent(u,unit$exponent[i]);
 Unit_setMultiplier(u,unit$multiplier[i]);
 Unit_setScale(u,unit$scale[i]);
}
```

Default units are set by defining units with the special ids:

- time
- substance
- volume
- area
- length

### Compartments

```R
comp <- Model_createCompartment(model);
Compartment_setId(comp, compName);
Compartment_setSize(comp, 1);
```

### Species (Molecules and Complexes of Molecules)

```R
sp <- Model_createSpecies(model);
Species_setUnits(sp, SubstanceUnitID)
Species_setId(sp, "S2");
Species_setCompartment(sp, compName);
Species_setInitialConcentration(sp, 0);
```

where `SubstanceUnitID` is a string identifier of a unit definition.

### Expressions

SBML has no entity that exactly matches an _Expression_ role. We have to convert them into species, or parameters (maybe even compartments)

The difference is that simulators treat parameters and species as arguments to the model, say `y'=f(y,p)`, but expressions are supposed to be model internal values (autonomous).

libsbml provides these functions to make `AssignmentRule`s:

```R
rule <- Model_createAssignmentRule(sbml)
astMath <- parseFormula(Expression$Formula[i]);
Rule_setFormula(rule, astMath)
```

### Parameters

```R
para <- Model_createParameter(model);
Parameter_setId(para, "t");
Parameter_setValue(para, 1);
Parameter_setUnits(para, "second");

```

### Reactions

```R
reaction <- Model_createReaction(model);
Reaction_setId(reaction, "reaction_1");
Reaction_setReversible(reaction, 0);

kl = Reaction_createKineticLaw(reaction);
astMath <- parseFormula(MathString); # or: readMathMLFromString(mathXMLString);
KineticLaw_setMath(kl, astMath);

```
  

