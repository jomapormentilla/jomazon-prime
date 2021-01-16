def start
    create_store
end

def create_store
    Store.create(name: "Jomazon")
end

start