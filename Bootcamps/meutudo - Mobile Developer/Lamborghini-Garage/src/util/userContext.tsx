import { createContext, useState, ReactNode, useEffect } from "react";
import { fetchGetCarData } from './getCarsApi';
import { CarModel } from '../components/props';

interface userContextCar {
    carData: CarModel | null;
    handlePreviousItem: () => void;
    handleNextItem: () => void;
    changeCar: (id: number, name: string) => void;
}

export const UserContext = createContext<userContextCar|undefined>(undefined);

export const UserContextProvider = ({ children }: { children: ReactNode }) => {
    const [carData, setCarData] = useState<CarModel | null>(null);

    useEffect(() => {
        (async() => {
            const initialCarData = await fetchGetCarData(1);
            setCarData(initialCarData);
        })();
    }, []);

    const handleNextItem = async () => {
        if (!carData) return;
        const nextId = carData.id === 10 ? 1 : carData.id + 1;
        const nextCar = await fetchGetCarData(nextId);
        setCarData(nextCar);
    };

    const handlePreviousItem = async () => {
        if (!carData) return;
        const previousId = carData.id === 1 ? 10 : carData.id - 1;
        const previousCar = await fetchGetCarData(previousId);
        setCarData(previousCar);
    };

    const changeCar = (id: number, name: string) => {
        if (carData) setCarData({...carData, id, carName: name});
    };

    const contextValue: userContextCar = {
        carData,
        handlePreviousItem,
        handleNextItem,
        changeCar,
    };

    return (
        <UserContext.Provider 
            value={ contextValue }>
            {children}
        </UserContext.Provider>
    );
}