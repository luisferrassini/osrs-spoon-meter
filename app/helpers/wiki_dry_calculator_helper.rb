module WikiDryCalculatorHelper
  def expr(x)
    x = x.to_s.tr(',', '.')
    begin
      eval(x)
    rescue SyntaxError, NameError => e
      puts "Error evaluating expression: #{e.message}"
      nil
    end
  end

  def choose(n, k)
    return 0 if k < 0 || k > n
    return 1 if k == 0 || k == n

    k = [k, n - k].min # symmetry
    c = 1
    (0...k).each do |i|
      c *= (n - i) / (k - i).to_f
    end
    c
  end

  FLAVOUR_TEXTS = [
    [-1, 1, "You are some sort of sentient water being you're so not-dry. How'd you even do this?"],
    [1, 10, "You're a higher % water than a watermelon.",
     "Or you would be if you had gotten any drops. But you didn't."],
    [10, 20, 'Only ironmen can be this lucky.', "But you got no drops, so I guess you're not an ironman."],
    [20, 30, '🥄 Spooned 🥄', 'j/k you got no drops'],
    [30, 40, 'Your friends will be jealous.', '...If you got any drops.'],
    [40, 49, "You're quite the lucker aren't you.", 'Or not, since you got no drops.'],
    [49, 51, 'A perfect mix of dry and undry, as all things should be.'],
    [51, 61, 'Nothing interesting happens.', 'Not even any drops.'],
    [61, 65,
     "An unenlightened being would say 'but 1/x over x kills means I should get it', but you know better now."],
    [65, 73, 'Nothing interesting happens.', 'Not even any drops.'],
    [73, 74, '😂😂😂'],
    [74, 85, 'oof'],
    [85, 90, 'A national emergency has been declared in your drop log.'],
    [90, 95, 'Right, time to post on reddit.'],
    [95, 99, 'You after being this dry: [[File:Skeleton.png|80x80px]]'],
    [99, 99.5, 'You are so dry you have collapsed into the dry singularity. The dryularity, if you will.'],
    [99.5, 99.9, 'The vacuum of space has more activity than your drop log.'],
    [99.9, 99.99,
     "Wow that's so rare! Seems like it's bugged. We tweeted @JagexAsh for you, we're sure he'll get to the bottom of it in the next 24 hours."],
    [99.99, 1000, 'Did you forget to talk to [[Oziach]]?']
  ].freeze

  def flavour_text(x, obtained)
    FLAVOUR_TEXTS.each do |v|
      next unless x >= v[0] && x <= v[1]
      return "#{v[2]} #{v[3]}" if obtained.zero? && v[3]

      return v[2]
    end
    ''
  end

  def dry_calculator(chance_txt, kc, obtained)
    chance = expr(chance_txt)
    return 'Looks like there was an error with your input chance, try typing it in again' unless chance

    return 'You put your chance at over 1 you absolute madman' if chance > 1
    return 'You put your chance at 0 or negative, how you gonna get that drop?' if chance <= 0

    kc = kc.to_i
    return "You ain't killed anything you crazy fool" unless kc.positive?

    obtained = obtained.to_i
    return 'More items dropped than things killed? how?' if kc < obtained

    luck = 0.0
    (0..obtained).each do |i|
      luck += choose(kc, i) * (chance**i) * ((1 - chance)**(kc - i))
    end

    [
      (1.0 - luck) * 100,
      format(
        "You killed %s monsters for an item with a %s (%.6f%%) drop chance. You had a:\n* %.8f%% chance of getting %s drops or fewer\n* %.8f%% chance of getting more than %s drops. %s", kc, chance_txt, 100 * chance, 100 * luck, obtained, 100 * (1.0 - luck), obtained, flavour_text(
                                                                                                                                                                                                                                                                              (1.0 - luck) * 100, obtained
                                                                                                                                                                                                                                                                            )
      ),
      "You killed #{kc} monsters for an item with a #{chance_txt} (#{(100 * chance).round(6)}%) drop chance.",
      "#{(100 * luck).round(8)}% chance of getting #{obtained} drops or fewer.",
      "#{(100 * (1.0 - luck)).round(8)}% chance of getting more than #{obtained} drops.",
      flavour_text((1.0 - luck) * 100, obtained)
    ]
  end
end
