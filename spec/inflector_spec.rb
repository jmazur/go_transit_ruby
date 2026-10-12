RSpec.describe GoTransit::Inflector do
  def fixture_keys
    @fixture_keys ||= begin
      files = Dir[File.join(File.dirname(__FILE__), "support/fixtures/*.json")]
      files.each_with_object(Hash.new { |h, k| h[k] = [] }) do |file, found|
        collect_keys(JSON.parse(File.read(file)), found)
      end
    end
  end

  def collect_keys(node, found)
    case node
    when Hash
      node.each do |key, value|
        found[:all] << key
        found[:lists] << key if value.kind_of?(Array)
        found[:lists] << value.first.first if wraps_list?(value)
        collect_keys(value, found)
      end
    when Array
      node.each { |item| collect_keys(item, found) }
    end
  end

  def wraps_list?(value)
    value.kind_of?(Hash) && value.first && value.first.last.kind_of?(Array)
  end

  def uniq(kind)
    fixture_keys[kind].uniq
  end

  it "has real fixtures to compare against" do
    expect(uniq(:all).size).to be > 150
    expect(uniq(:lists).size).to be > 20
  end

  describe ".underscore" do
    it "matches ActiveSupport for every key" do
      mismatches = uniq(:all).reject { |key| described_class.underscore(key) == key.underscore }

      expect(mismatches).to be_empty
    end

    it "matches ActiveSupport on random mixes of capitals, lowercase letters, digits and underscores" do
      random = Random.new(2026)
      alphabet = [*"A".."Z", *"a".."z", *"0".."9", "_"]
      words = Array.new(3000) { Array.new(random.rand(1..14)) { alphabet[random.rand(alphabet.size)] }.join }

      mismatches = words.reject { |word| described_class.underscore(word) == word.underscore }

      expect(mismatches).to be_empty
    end

    it "takes linear time on a very long run of digits or capitals" do
      ["0" * 200_000, "A" * 200_000, "A0" * 100_000, "#{"0" * 200_000}x"].each do |word|
        expect { Timeout.timeout(2) { described_class.underscore(word) } }.not_to raise_error
      end
    end

    it "splits acronyms and digits like ActiveSupport" do
      %w[TripNumber IsInMotion ID HTMLParser Line2Stop already_snake].each do |word|
        expect(described_class.underscore(word)).to eq(word.underscore)
      end
    end
  end

  describe ".singularize and .pluralize" do
    it "match ActiveSupport for every list key" do
      mismatches = uniq(:lists).reject do |key|
        described_class.singularize(key) == key.singularize &&
          described_class.pluralize(key) == key.pluralize &&
          described_class.pluralize(key.singularize) == key.singularize.pluralize
      end

      expect(mismatches).to be_empty
    end

    it "is idempotent, because hydrate pluralizes keys that may already be plural" do
      %w[Trips Trip entities entity Facilities Facility].each do |word|
        expect(described_class.pluralize(word)).to eq(word.pluralize)
        expect(described_class.pluralize(described_class.pluralize(word))).to eq(word.pluralize)
      end
    end

    it "handles words ending in ss and y like ActiveSupport" do
      %w[Address Category Day Key].each do |word|
        expect(described_class.pluralize(word)).to eq(word.pluralize)
        expect(described_class.singularize(word.pluralize)).to eq(word)
      end
    end
  end
end
