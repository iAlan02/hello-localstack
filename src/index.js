exports.handler = async(event) => {
    const name = event.name;

    return {
        statusCode: 200,
        body: {
            message: `Hello World`
        }
    };
}