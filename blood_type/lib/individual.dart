class Genotype {
  final List<String> genotypes = ['AA', 'Ai', 'BB', 'Bi', 'AB', 'ii'];
  late String genotype;

  Genotype(String text) {
    if (genotypes.contains(text)) {
      genotype = text;
    } else {
      throw FormatException('Bad individual genotype: $text');
    }
  }

  String bloodType() {
    if (genotype == 'AA' || genotype == 'Ai') {
      return 'A';
    } else if (genotype == 'BB' || genotype == 'Bi') {
      return 'B';
    } else if (genotype == 'AB') {
      return 'AB';
    } else {
      return 'O';
    }
  }

  List alleles() {
    late List<String> allele = [];
    if (genotype[0] == genotype[1]) {
      allele.add(genotype[0]);
    } else {
      allele.add(genotype[0]);
      allele.add(genotype[1]);
    }
    return allele;
  }

  List agglutinogens() {
    late List<String> agglutinogen = [];
    if (genotype == 'AA' || genotype == 'Ai') {
      agglutinogen.add('A');
    } else if (genotype == 'BB' || genotype == 'Bi') {
      agglutinogen.add('B');
    } else if (genotype == 'AB') {
      agglutinogen.add('A');
      agglutinogen.add('B');
    }
    return agglutinogen;
  }

  List agglutinins() {
    late List<String> agglutinin = [];
    if (genotype == 'AA' || genotype == 'Ai') {
      agglutinin.add('B');
    } else if (genotype == 'BB' || genotype == 'Bi') {
      agglutinin.add('A');
    } else if (genotype == 'ii') {
      agglutinin.add('A');
      agglutinin.add('B');
    }
    return agglutinin;
  }

  List offsprings(Genotype indiv2) {
    late Set<String> offspringSet = {};
    late List<String> offspring = [];
    final List genes1 = genotype.split('');
    final List genes2 = indiv2.genotype.split('');

    offspringSet.add(genes1[0].toString() + genes2[0].toString());
    offspringSet.add(genes1[0].toString() + genes2[1].toString());
    offspringSet.add(genes1[1].toString() + genes2[0].toString());
    offspringSet.add(genes1[1].toString() + genes2[1].toString());
    offspring = offspringSet.toList();
    for (var gene in offspring) {
      if (gene == 'BA') {
        offspring.remove('BA');
        offspring.add('AB');
      }
      if (gene == 'iA') {
        offspring.remove('iA');
        offspring.add('Ai');
      }
      if (gene == 'iB') {
        offspring.remove('iB');
        offspring.add('Bi');
      }
    }
    return offspring;
  }

  bool compatible(Genotype indv2) {
    bool donate = false;
    switch (genotype) {
      case 'ii':
        donate = true;
      case 'AB':
        if (indv2.genotype == 'AB') {
          donate = true;
        }
      case 'AA' || 'Ai':
        if (indv2.genotype == 'AA' ||
            indv2.genotype == 'Ai' ||
            indv2.genotype == 'AB') {
          donate = true;
        }
      case 'BB' || 'Bi':
        if (indv2.genotype == 'BB' ||
            indv2.genotype == 'Bi' ||
            indv2.genotype == 'AB') {
          donate = true;
        }
    }
    return donate;
  }
}

class Individual extends Genotype {
  static int count = 0;
  late String indiv;

  Individual(String text, [String? name]) : super(text) {
    count += 1;
    if (name != null) {
      indiv = name;
    } else {
      indiv = 'Indiv$count';
    }
  }

  @override
  String toString() {
    return '$indiv($genotype)';
  }
}
