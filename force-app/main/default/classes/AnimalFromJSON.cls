public class AnimalFromJSON {
    public Animal animal;

	public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}

	public static AnimalFromJSON parse(String json) {
		return (AnimalFromJSON) System.JSON.deserialize(json, AnimalFromJSON.class);
	}
    
}